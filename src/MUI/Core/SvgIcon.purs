{- This module was autogenerated. Please don't edit. -}
module MUI.Core.SvgIcon where

import MUI.Core (JSS, class Nub')
import MUI.Core.Styles (Theme, withStyles) as MUI.Core.Styles
import Prelude
import Prim.Row (class Union) as Prim.Row
import React.Basic (JSX, ReactComponent, element)
import React.Basic.DOM.SVG (Props_svg) as React.Basic.DOM.SVG
import Unsafe.Coerce (unsafeCoerce)
import Unsafe.Reference (unsafeRefEq)

foreign import data Color :: Type

color ::
  { action :: Color
  , disabled :: Color
  , error :: Color
  , inherit :: Color
  , primary :: Color
  , secondary :: Color
  }
color = { action: unsafeCoerce "action", disabled: unsafeCoerce "disabled", error: unsafeCoerce "error", inherit: unsafeCoerce "inherit", primary: unsafeCoerce "primary", secondary: unsafeCoerce "secondary" }

foreign import data FontSize :: Type

fontSize ::
  { default :: FontSize
  , inherit :: FontSize
  , large :: FontSize
  , small :: FontSize
  }
fontSize = { default: unsafeCoerce "default", inherit: unsafeCoerce "inherit", large: unsafeCoerce "large", small: unsafeCoerce "small" }

instance eqFontSize :: Eq FontSize where
  eq = unsafeRefEq

instance eqColor :: Eq Color where
  eq = unsafeRefEq

type SvgIconClassesGenericRow a
  = ( colorAction :: a
    , colorDisabled :: a
    , colorError :: a
    , colorPrimary :: a
    , colorSecondary :: a
    , fontSizeInherit :: a
    , fontSizeLarge :: a
    , fontSizeSmall :: a
    , root :: a
    )

type SvgIconClassesKey
  = SvgIconClassesGenericRow String

type SvgIconClassesJSS
  = SvgIconClassesGenericRow JSS

type SvgIconOptPropsRow (r :: #Type)
  = ( children :: Array JSX
    , classes :: { | SvgIconClassesKey }
    , color :: Color
    , fontSize :: FontSize
    , htmlColor :: String
    , shapeRendering :: String
    , titleAccess :: String
    , viewBox :: String
    | r
    )

type SvgIconReqPropsRow (r :: #Type)
  = r

type SvgIconPropsRow (r :: #Type)
  = SvgIconOptPropsRow (SvgIconReqPropsRow r)

foreign import _UnsafeSvgIcon :: forall componentProps. ReactComponent { | SvgIconPropsRow componentProps }

_SvgIcon ::
  forall given optionalGiven optionalMissing props required.
  Nub' (SvgIconReqPropsRow ()) required =>
  Prim.Row.Union required optionalGiven given =>
  Nub' (SvgIconPropsRow React.Basic.DOM.SVG.Props_svg) props =>
  Prim.Row.Union given optionalMissing props =>
  ReactComponent { | given }
_SvgIcon = unsafeCoerce _UnsafeSvgIcon

svgIcon ::
  forall given optionalGiven optionalMissing props required.
  Nub' (SvgIconReqPropsRow ()) required =>
  Prim.Row.Union required optionalGiven given =>
  Nub' (SvgIconPropsRow React.Basic.DOM.SVG.Props_svg) props =>
  Prim.Row.Union given optionalMissing props =>
  { | given } -> JSX
svgIcon props = element _SvgIcon props

svgIconWithStyles ::
  forall jss_ jss given optionalGiven optionalMissing props required.
  Nub' (SvgIconReqPropsRow ()) required =>
  Prim.Row.Union required optionalGiven given =>
  Nub' (SvgIconPropsRow React.Basic.DOM.SVG.Props_svg) props =>
  Prim.Row.Union given optionalMissing props =>
  Prim.Row.Union jss jss_ SvgIconClassesJSS =>
  (MUI.Core.Styles.Theme -> { | jss }) -> { | given } -> JSX
svgIconWithStyles style props = element (withStyles' style _SvgIcon) props
  where
  withStyles' :: (MUI.Core.Styles.Theme -> { | jss }) -> ReactComponent { | given } -> ReactComponent { | given }
  withStyles' = unsafeCoerce MUI.Core.Styles.withStyles

foreign import data SvgIconProps :: Type

svgIconProps ::
  forall given optionalGiven optionalMissing props required.
  Nub' (SvgIconReqPropsRow ()) required =>
  Prim.Row.Union required optionalGiven given =>
  Nub' (SvgIconPropsRow React.Basic.DOM.SVG.Props_svg) props =>
  Prim.Row.Union given optionalMissing props =>
  { | SvgIconReqPropsRow given } -> SvgIconProps
svgIconProps = unsafeCoerce
