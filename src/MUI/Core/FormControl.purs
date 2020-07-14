{- This module was autogenerated. Please don't edit. -}
module MUI.Core.FormControl where

import MUI.Core (JSS, class Nub')
import MUI.Core.Styles (Theme, withStyles) as MUI.Core.Styles
import Prelude
import Prim.Row (class Union) as Prim.Row
import React.Basic (JSX, ReactComponent, element)
import React.Basic.DOM (Props_div) as React.Basic.DOM
import Unsafe.Coerce (unsafeCoerce)
import Unsafe.Reference (unsafeRefEq)

foreign import data Color :: Type

color ::
  { primary :: Color
  , secondary :: Color
  }
color = { primary: unsafeCoerce "primary", secondary: unsafeCoerce "secondary" }

foreign import data Margin :: Type

margin ::
  { dense :: Margin
  , none :: Margin
  , normal :: Margin
  }
margin = { dense: unsafeCoerce "dense", none: unsafeCoerce "none", normal: unsafeCoerce "normal" }

foreign import data Variant :: Type

variant ::
  { filled :: Variant
  , outlined :: Variant
  , standard :: Variant
  }
variant = { filled: unsafeCoerce "filled", outlined: unsafeCoerce "outlined", standard: unsafeCoerce "standard" }

instance eqVariant :: Eq Variant where
  eq = unsafeRefEq

instance eqMargin :: Eq Margin where
  eq = unsafeRefEq

instance eqColor :: Eq Color where
  eq = unsafeRefEq

type FormControlClassesGenericRow a
  = ( fullWidth :: a
    , marginDense :: a
    , marginNormal :: a
    , root :: a
    )

type FormControlClassesKey
  = FormControlClassesGenericRow String

type FormControlClassesJSS
  = FormControlClassesGenericRow JSS

type FormControlOptPropsRow (r :: #Type)
  = ( children :: Array JSX
    , classes :: { | FormControlClassesKey }
    , color :: Color
    , disabled :: Boolean
    , error :: Boolean
    , fullWidth :: Boolean
    , hiddenLabel :: Boolean
    , margin :: Margin
    , required :: Boolean
    , variant :: Variant
    | r
    )

type FormControlReqPropsRow (r :: #Type)
  = r

type FormControlPropsRow (r :: #Type)
  = FormControlOptPropsRow (FormControlReqPropsRow r)

foreign import _UnsafeFormControl :: forall componentProps. ReactComponent { | FormControlPropsRow componentProps }

_FormControl ::
  forall given optionalGiven optionalMissing props required.
  Nub' (FormControlReqPropsRow ()) required =>
  Prim.Row.Union required optionalGiven given =>
  Nub' (FormControlPropsRow React.Basic.DOM.Props_div) props =>
  Prim.Row.Union given optionalMissing props =>
  ReactComponent { | given }
_FormControl = unsafeCoerce _UnsafeFormControl

formControl ::
  forall given optionalGiven optionalMissing props required.
  Nub' (FormControlReqPropsRow ()) required =>
  Prim.Row.Union required optionalGiven given =>
  Nub' (FormControlPropsRow React.Basic.DOM.Props_div) props =>
  Prim.Row.Union given optionalMissing props =>
  { | given } -> JSX
formControl props = element _FormControl props

formControlWithStyles ::
  forall jss_ jss given optionalGiven optionalMissing props required.
  Nub' (FormControlReqPropsRow ()) required =>
  Prim.Row.Union required optionalGiven given =>
  Nub' (FormControlPropsRow React.Basic.DOM.Props_div) props =>
  Prim.Row.Union given optionalMissing props =>
  Prim.Row.Union jss jss_ FormControlClassesJSS =>
  (MUI.Core.Styles.Theme -> { | jss }) -> { | given } -> JSX
formControlWithStyles style props = element (withStyles' style _FormControl) props
  where
  withStyles' :: (MUI.Core.Styles.Theme -> { | jss }) -> ReactComponent { | given } -> ReactComponent { | given }
  withStyles' = unsafeCoerce MUI.Core.Styles.withStyles

foreign import data FormControlProps :: Type

formControlProps ::
  forall given optionalGiven optionalMissing props required.
  Nub' (FormControlReqPropsRow ()) required =>
  Prim.Row.Union required optionalGiven given =>
  Nub' (FormControlPropsRow React.Basic.DOM.Props_div) props =>
  Prim.Row.Union given optionalMissing props =>
  { | FormControlReqPropsRow given } -> FormControlProps
formControlProps = unsafeCoerce
