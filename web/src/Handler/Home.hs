{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

data FileForm = FileForm
    { codeText :: Textarea
    }

getHomeR :: Handler Html
getHomeR = do
    (formWidget, formEnctype) <- generateFormPost sampleForm
    let submission = Nothing :: Maybe Text
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "RISC-V assembly converter"
        $(widgetFile "homepage")

postHomeR :: Handler Html
postHomeR = do
    ((result, formWidget), formEnctype) <- runFormPost sampleForm
    let submission = case result of
            FormSuccess res -> Just codeOutput
                where codeOutput = unlines $ headerFile (codeInput) (-1) (length codeInput)
                      codeInput = lines $ unpack $ unTextarea $ codeText res
            _ -> Nothing

    defaultLayout $ do
        aDomId <- newIdent
        setTitle "RISC-V assembly converter"
        $(widgetFile "homepage")

sampleForm :: Form FileForm
sampleForm = renderBootstrap3 BootstrapBasicForm $ FileForm
    <$> areq textareaField textSettings Nothing
    where textSettings = FieldSettings
            { fsLabel = "Input"
            , fsTooltip = Nothing
            , fsId = Just "assemblyInput"
            , fsName = Nothing
            , fsAttrs =
                [ ("class", "form-control")
                , ("onchange", "checkTextArea(this.value)")
                , ("onkeyup", "checkTextArea(this.value)")
                , ("spellcheck", "false")
                , ("placeholder", "Put your assembly code here")
                ]
            }
