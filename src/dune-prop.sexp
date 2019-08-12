; Props
(rule
 (targets gtkContainersProps.ml ogtkContainersProps.ml)
 (action (run propcc %{dep:gtkContainers.props})))

(rule
 (targets gtkActionProps.ml ogtkActionProps.ml)
 (action (run propcc %{dep:gtkAction.props})))

(rule
 (targets gtkAssistantProps.ml ogtkAssistantProps.ml)
 (action (run propcc %{dep:gtkAssistant.props})))

(rule
 (targets gtkBaseProps.ml ogtkBaseProps.ml)
 (action (run propcc %{dep:gtkBase.props})))

(rule
 (targets gtkBinProps.ml ogtkBinProps.ml)
 (action (run propcc %{dep:gtkBin.props})))

(rule
 (targets gtkBuilderProps.ml ogtkBuilderProps.ml)
 (action (run propcc %{dep:gtkBuilder.props})))

(rule
 (targets gtkButtonProps.ml ogtkButtonProps.ml)
 (action (run propcc %{dep:gtkButton.props})))

(rule
 (targets gtkEditProps.ml ogtkEditProps.ml)
 (action (run propcc %{dep:gtkEdit.props})))

(rule
 (targets gtkFileProps.ml ogtkFileProps.ml)
 (action (run propcc %{dep:gtkFile.props})))

; (rule
;  (targets gtkListProps.ml ogtkListProps.ml)
;  (action (run propcc %{dep:gtkList.props})))

(rule
 (targets gtkMenuProps.ml ogtkMenuProps.ml)
 (action (run propcc %{dep:gtkMenu.props})))

(rule
 (targets gtkMiscProps.ml ogtkMiscProps.ml)
 (action (run propcc %{dep:gtkMisc.props})))

(rule
 (targets gtkPackProps.ml ogtkPackProps.ml)
 (action (run propcc %{dep:gtkPack.props})))

(rule
 (targets gtkRangeProps.ml ogtkRangeProps.ml)
 (action (run propcc %{dep:gtkRange.props})))

(rule
 (targets gtkTextProps.ml ogtkTextProps.ml)
 (action (run propcc %{dep:gtkText.props})))

(rule
 (targets gtkTreeProps.ml ogtkTreeProps.ml)
 (action (run propcc %{dep:gtkTree.props})))
