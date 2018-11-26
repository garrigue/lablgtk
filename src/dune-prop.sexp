; Props
(rule
 (targets gtkActionProps.ml ogtkActionProps.ml)
 (action (run ./propcc.exe %{dep:gtkAction.props})))

(rule
 (targets gtkAssistantProps.ml ogtkAssistantProps.ml)
 (action (run ./propcc.exe %{dep:gtkAssistant.props})))

(rule
 (targets gtkBaseProps.ml ogtkBaseProps.ml)
 (action (run ./propcc.exe %{dep:gtkBase.props})))

(rule
 (targets gtkBinProps.ml ogtkBinProps.ml)
 (action (run ./propcc.exe %{dep:gtkBin.props})))

(rule
 (targets gtkBrokenProps.ml ogtkBrokenProps.ml)
 (action (run ./propcc.exe %{dep:gtkBroken.props})))

(rule
 (targets gtkButtonProps.ml ogtkButtonProps.ml)
 (action (run ./propcc.exe %{dep:gtkButton.props})))

(rule
 (targets gtkEditProps.ml ogtkEditProps.ml)
 (action (run ./propcc.exe %{dep:gtkEdit.props})))

(rule
 (targets gtkFileProps.ml ogtkFileProps.ml)
 (action (run ./propcc.exe %{dep:gtkFile.props})))

(rule
 (targets gtkListProps.ml ogtkListProps.ml)
 (action (run ./propcc.exe %{dep:gtkList.props})))

(rule
 (targets gtkMenuProps.ml ogtkMenuProps.ml)
 (action (run ./propcc.exe %{dep:gtkMenu.props})))

(rule
 (targets gtkMiscProps.ml ogtkMiscProps.ml)
 (action (run ./propcc.exe %{dep:gtkMisc.props})))

(rule
 (targets gtkPackProps.ml ogtkPackProps.ml)
 (action (run ./propcc.exe %{dep:gtkPack.props})))

(rule
 (targets gtkSourceView2Props.ml ogtkSourceView2Props.ml)
 (action (run ./propcc.exe %{dep:gtkSourceView2.props})))

(rule
 (targets gtkRangeProps.ml ogtkRangeProps.ml)
 (action (run ./propcc.exe %{dep:gtkRange.props})))

(rule
 (targets gtkTextProps.ml ogtkTextProps.ml)
 (action (run ./propcc.exe %{dep:gtkText.props})))

(rule
 (targets gtkTreeProps.ml ogtkTreeProps.ml)
 (action (run ./propcc.exe %{dep:gtkTree.props})))

; Gives a parsing error in gnomeCanvasProps.props
;
; (rule
;  (targets gnomeCanvasProps.ml ognomeCanvasProps.ml)
;  (action (run ./propcc.exe %{dep:gnomeCanvas.props})))
