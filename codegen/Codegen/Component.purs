module Codegen.Component where

import Prelude

import Codegen.AST (Declaration, RowLabel, Type, TypeName, UnionMember)
import Codegen.AST.Sugar.Type (app, array, constructor, typeRow') as Type
import Codegen.AST.Types (Fields) as AST.Types
import Codegen.TS.Types (InstanceProps, InstantiationStrategy)
import Data.Either (Either)
import Data.Foldable (intercalate)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(..))
import Data.Moldy (class Moldable, Moldy(..), moldMap, moldlDefault, moldrDefault)
import ReadDTS.Instantiation (Type) as ReadDTS.Instantiation

-- | Drives codegen of props row (specific for a component):
-- |
-- | * `base` - Manually build types which should be included in props.
-- |            This option is useful for props types hard for auto codegen.
-- | * `generate` - List of prop names which should be autogenerated. We
-- |
-- | * `instantiation` - A hakcy hook into codegen type specizliation step.
-- |
type PropsRow =
  { base :: AST.Types.Fields Type
  , generate :: Array RowLabel
  -- | An escape hatch for tweaking low level props extraction
  , ts ::
      { instantiation :: Maybe
        { extractProps :: ReadDTS.Instantiation.Type -> Either (Array String) InstanceProps
        , strategy :: InstantiationStrategy
        }
      , unionName :: String -> Array UnionMember -> Maybe TypeName
      }
  }

-- | Allows us to express the hierarchy of components
-- | but also the default root element of a given MUI
-- | component.
data Root
  = MUIComponent Component
  | RBProps Type

propsRequiredName :: ComponentName -> String
propsRequiredName cn = cn <> "ReqPropsRow"

propsCombinedName :: ComponentName -> String
propsCombinedName cn = cn <> "PropsRow"

propsOptionalName :: ComponentName -> String
propsOptionalName cn = cn <> "OptPropsRow"

type Symbol = String

-- | Premature optimization ;-)
fqn :: ModulePath -> Symbol -> String
fqn mp =
  let
    p = psImportPath (componentFullPath mp)
  in
    \s -> p <> "." <> s

type Props p =
  { combined :: p
  , optional :: p
  , required :: p
  }

foldRoot :: { component :: Component, local :: Boolean } -> Props Type
foldRoot = case _ of
  c@{ component, local: false } -> go (MUIComponent component)
  { component: component@{ root: root }, local: true } ->
    let
      cn = componentName component
      toConstructor = Type.constructor
    in
      wrapInProps
        { componentName: cn, toConstructor, root }

  where
    wrapInProps { componentName: cn, toConstructor, root } =
      let
        { combined, optional, required } = go root
        propsRequired = toConstructor $ propsRequiredName cn
        propsOptional = toConstructor $ propsOptionalName cn
        propsCombined = toConstructor $ propsCombinedName cn
      in
        { combined: Type.app propsCombined [ combined ]
        , optional: Type.app propsOptional [ optional ]
        , required: Type.app propsRequired [ required ]
        }

    go (RBProps t) =
      { combined: t, optional: t, required: Type.typeRow' mempty Nothing }
    go (MUIComponent c) =
      let
        cn = componentName c
        fqn' = fqn c.modulePath.output
        toConstructor = Type.constructor <<< fqn'
      in
        wrapInProps { componentName: cn, toConstructor, root: c.root }

rbProps ::
  { a :: Root
  , button :: Root
  , div :: Root
  , hr :: Root
  , label :: Root
  , p :: Root
  , svg :: Root
  }
rbProps =
  { a: p "Props_a"
  , button: p "Props_button"
  , div: p "Props_div"
  , hr: p "Props_hr"
  , label: p "Props_label"
  , p: p "Props_p"
  , svg: p "SVG.Props_svg"
  }
  where
    p = RBProps <<< Type.constructor <<< append "React.Basic.DOM."


-- | Drives generation of a given MUI component.
-- | TODO: annotate this type with finall props etc.
-- | so we can use this info to simplify child
-- | component codegen (checking overlap between props etc.).
type Component =
  { extraDeclarations :: Array Declaration
  -- | `ModulePath` value relative to `@material-ui/core/`
  , modulePath ::
    { input :: ModulePath
    , output :: ModulePath
    }
  , propsRow :: PropsRow
  , root :: Root
  }

type ComponentName = String

componentName :: Component -> ComponentName
componentName = pathName <<< _.modulePath.output

inputComponentName :: Component -> ComponentName
inputComponentName = pathName <<< _.modulePath.input

-- | I'm not sure why we have this distinction and operate on a subpath
-- | in component specification... This should be probably cleaned up.
componentFullPath :: ModulePath -> ModulePath
componentFullPath modulePath = Path "MUI" (Path "Core" modulePath)

type IconName = String

-- | We should probably have here `ModulePath` for consistency
-- | but icons are located directly under `@material-ui/icons/`
-- | so we can use string to simplify some processing and FFI.
newtype Icon = Icon IconName

derive instance eqIcon :: Eq Icon

iconName :: Icon -> IconName
iconName (Icon s) = s

-- | Module path relative to `@material-ui/icons`
iconPath :: Icon -> ModulePath
iconPath (Icon s) = Name s

iconFullPath :: Icon -> ModulePath
iconFullPath icon = Path "MUI" (Path "Icons" (iconPath icon))

-- | This ADT is used to describe the name of the Purescript module. It's also used to determine file names and generate FFI.
-- | Because it's used for FFI generation, it should mimic the structure of `@material-ui`. For example, when writing the
-- | `Typography` component, it's JS import is `@material-ui/core/Typography` so the correct value for module is
-- | `Path "MUI" (Path "Core" (Name "Typography"))`. Note that `MUI` will be removed in the FFI, so you get FFI that looks like
-- | `exports._Typography = require("@material-ui/core/Typography").default;`. That said, the module name in the generated
-- | PureScript will be `MUI.Core.Typography`
data ModulePath
  = Path String ModulePath
  | Name String

derive instance eqModulePath :: Eq ModulePath

derive instance ordModulePath :: Ord ModulePath

derive instance genericModulePath :: Generic ModulePath _

instance showModulePath :: Show ModulePath where
  show m = genericShow m

instance moldableModulePath :: Moldable ModulePath String where
  moldMap f (Path p m) = f p <> moldMap f m
  moldMap f (Name n) = f n
  moldl f z m = moldlDefault f z m
  moldr f z m = moldrDefault f z m

pathName :: ModulePath -> String
pathName (Name n) = n
pathName (Path _ p) = pathName p

psImportPath :: ModulePath -> String
psImportPath modulePath = intercalate "." (Moldy identity modulePath)

jsImportPath :: ModulePath -> String
jsImportPath modulePath = intercalate "/" (Moldy identity modulePath)

jsx :: Type
jsx = Type.constructor "React.Basic.JSX"

arrayJSX :: Type
arrayJSX = Type.array $ jsx

reactComponentApply :: Type -> Type
reactComponentApply t = Type.app (Type.constructor "React.Basic.ReactComponent") [ t ]

nativeElementProps :: Type
nativeElementProps = Type.constructor "MUI.Core.NativeElementProps"

eventHandler :: Type
eventHandler = Type.constructor "React.Basic.Events.EventHandler"
