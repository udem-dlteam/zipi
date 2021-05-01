;; generated file, don't edit
;; (new-PycUnimplemented loc msg #!key (%info #f))
(define-inline (new-PycUnimplemented loc msg #!key (%info #f))
   (make-PycUnimplemented loc %info msg))

;; (new-PycModule loc ident stmts #!key (%info #f) (special-init #f) (version 1) (globals (quote ())) (global-defs (quote ())) (caches -1))
(define-inline (new-PycModule loc ident stmts #!key (%info #f) (special-init #f) (version 1) (globals (quote ())) (global-defs (quote ())) (caches -1))
   (make-PycModule loc %info special-init version ident stmts globals global-defs caches))

;; (new-PycVar loc id scope #!key (%info #f) (name #f) (key (genkey)) (in-scope-of #f) (usage (quote ())) (assig (quote ())) (can-be-deleted #f) (global-only-accessed-in-module #f) (global-always-defined #f) (global-ref-to-init-def #f) (is-builtin #f) (simple-scoping-top-block #f) (cache #f))
(define-inline (new-PycVar loc id scope #!key (%info #f) (name #f) (key (genkey)) (in-scope-of #f) (usage (quote ())) (assig (quote ())) (can-be-deleted #f) (global-only-accessed-in-module #f) (global-always-defined #f) (global-ref-to-init-def #f) (is-builtin #f) (simple-scoping-top-block #f) (cache #f))
   (make-PycVar loc %info id scope name key in-scope-of usage assig can-be-deleted global-only-accessed-in-module global-always-defined global-ref-to-init-def is-builtin simple-scoping-top-block cache))

;; (new-PycStmt loc #!key (%info #f) (need-return #f))
(define-inline (new-PycStmt loc #!key (%info #f) (need-return #f))
   (make-PycStmt loc %info need-return))

;; (new-PycSeq loc nodes #!key (%info #f) (need-return #f))
(define-inline (new-PycSeq loc nodes #!key (%info #f) (need-return #f))
   (make-PycSeq loc %info need-return nodes))

;; (new-PycBlock loc decls body #!key (%info #f) (need-return #f))
(define-inline (new-PycBlock loc decls body #!key (%info #f) (need-return #f))
   (make-PycBlock loc %info need-return decls body))

;; (new-PycReturn loc val #!key (%info #f) (need-return #f) (tail #t))
(define-inline (new-PycReturn loc val #!key (%info #f) (need-return #f) (tail #t))
   (make-PycReturn loc %info need-return val tail))

;; (new-PycReturnYield loc val kont #!key (%info #f) (need-return #f) (generator #f))
(define-inline (new-PycReturnYield loc val kont #!key (%info #f) (need-return #f) (generator #f))
   (make-PycReturnYield loc %info need-return val kont generator))

;; (new-PycDelete loc expr #!key (%info #f) (need-return #f))
(define-inline (new-PycDelete loc expr #!key (%info #f) (need-return #f))
   (make-PycDelete loc %info need-return expr))

;; (new-PycAssig loc lhs rhs #!key (%info #f) (need-return #f))
(define-inline (new-PycAssig loc lhs rhs #!key (%info #f) (need-return #f))
   (make-PycAssig loc %info need-return lhs rhs))

;; (new-PycAugAssig loc lhs rhs op #!key (%info #f) (need-return #f) (cache #f))
(define-inline (new-PycAugAssig loc lhs rhs op #!key (%info #f) (need-return #f) (cache #f))
   (make-PycAugAssig loc %info need-return lhs rhs op cache))

;; (new-PycIf loc test then else #!key (%info #f) (need-return #f))
(define-inline (new-PycIf loc test then else #!key (%info #f) (need-return #f))
   (make-PycIf loc %info need-return test then else))

;; (new-PycWithItem loc context-expr optional-vars #!key (%info #f) (need-return #f))
(define-inline (new-PycWithItem loc context-expr optional-vars #!key (%info #f) (need-return #f))
   (make-PycWithItem loc %info need-return context-expr optional-vars))

;; (new-PycWith loc items body #!key (%info #f) (need-return #f))
(define-inline (new-PycWith loc items body #!key (%info #f) (need-return #f))
   (make-PycWith loc %info need-return items body))

;; (new-PycLoop loc body else #!key (%info #f) (need-return #f) (need-break #t) (need-continue #t))
(define-inline (new-PycLoop loc body else #!key (%info #f) (need-return #f) (need-break #t) (need-continue #t))
   (make-PycLoop loc %info need-return body else need-break need-continue))

;; (new-PycFor loc body else target iter #!key (%info #f) (need-return #f) (need-break #t) (need-continue #t) (cachei #f) (cachen #f))
(define-inline (new-PycFor loc body else target iter #!key (%info #f) (need-return #f) (need-break #t) (need-continue #t) (cachei #f) (cachen #f))
   (make-PycFor loc %info need-return body else need-break need-continue target iter cachei cachen))

;; (new-PycWhile loc body else test #!key (%info #f) (need-return #f) (need-break #t) (need-continue #t))
(define-inline (new-PycWhile loc body else test #!key (%info #f) (need-return #f) (need-break #t) (need-continue #t))
   (make-PycWhile loc %info need-return body else need-break need-continue test))

;; (new-PycRaise loc exc cause #!key (%info #f) (need-return #f))
(define-inline (new-PycRaise loc exc cause #!key (%info #f) (need-return #f))
   (make-PycRaise loc %info need-return exc cause))

;; (new-PycTry loc body handlers else finally exc-sym #!key (%info #f) (need-return #f) (tail #t))
(define-inline (new-PycTry loc body handlers else finally exc-sym #!key (%info #f) (need-return #f) (tail #t))
   (make-PycTry loc %info need-return body handlers else finally exc-sym tail))

;; (new-PycHandler loc type body #!key (%info #f))
(define-inline (new-PycHandler loc type body #!key (%info #f))
   (make-PycHandler loc %info type body))

;; (new-PycBreak loc #!key (%info #f) (need-return #f))
(define-inline (new-PycBreak loc #!key (%info #f) (need-return #f))
   (make-PycBreak loc %info need-return))

;; (new-PycContinue loc #!key (%info #f) (need-return #f))
(define-inline (new-PycContinue loc #!key (%info #f) (need-return #f))
   (make-PycContinue loc %info need-return))

;; (new-PycPass loc #!key (%info #f) (need-return #f))
(define-inline (new-PycPass loc #!key (%info #f) (need-return #f))
   (make-PycPass loc %info need-return))

;; (new-PycStmtExpr loc expr #!key (%info #f) (need-return #f))
(define-inline (new-PycStmtExpr loc expr #!key (%info #f) (need-return #f))
   (make-PycStmtExpr loc %info need-return expr))

;; (new-PycSymbols loc scope names #!key (%info #f) (need-return #f))
(define-inline (new-PycSymbols loc scope names #!key (%info #f) (need-return #f))
   (make-PycSymbols loc %info need-return scope names))

;; (new-PycExpr loc #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycExpr loc #!key (%info #f) (type (quote unknown)))
   (make-PycExpr loc %info type))

;; (new-PycStarredExpr loc expr #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycStarredExpr loc expr #!key (%info #f) (type (quote unknown)))
   (make-PycStarredExpr loc %info type expr))

;; (new-PycPragma loc expr #!key (%info #f) (type (quote unknown)) (lang (quote scheme)))
(define-inline (new-PycPragma loc expr #!key (%info #f) (type (quote unknown)) (lang (quote scheme)))
   (make-PycPragma loc %info type lang expr))

;; (new-PycRef loc decl ctx #!key (%info #f) (type (quote unknown)) (cache #f) (can-direct-access #f))
(define-inline (new-PycRef loc decl ctx #!key (%info #f) (type (quote unknown)) (cache #f) (can-direct-access #f))
   (make-PycRef loc %info type decl ctx cache can-direct-access))

;; (new-PycRefUnresolved loc id ctx #!key (%info #f) (type (quote unknown)) (cache #f))
(define-inline (new-PycRefUnresolved loc id ctx #!key (%info #f) (type (quote unknown)) (cache #f))
   (make-PycRefUnresolved loc %info type id ctx cache))

;; (new-PycAccess loc obj field #!key (%info #f) (type (quote unknown)) (usage #f) (cache #f))
(define-inline (new-PycAccess loc obj field #!key (%info #f) (type (quote unknown)) (usage #f) (cache #f))
   (make-PycAccess loc %info type obj field usage cache))

;; (new-PycSubscript loc obj index #!key (%info #f) (type (quote unknown)) (cache #f))
(define-inline (new-PycSubscript loc obj index #!key (%info #f) (type (quote unknown)) (cache #f))
   (make-PycSubscript loc %info type obj index cache))

;; (new-PycSlice loc obj lower upper step #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycSlice loc obj lower upper step #!key (%info #f) (type (quote unknown)))
   (make-PycSlice loc %info type obj lower upper step))

;; (new-PycIfExp loc test body orelse #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycIfExp loc test body orelse #!key (%info #f) (type (quote unknown)))
   (make-PycIfExp loc %info type test body orelse))

;; (new-PycAssert loc test msg #!key (%info #f) (need-return #f))
(define-inline (new-PycAssert loc test msg #!key (%info #f) (need-return #f))
   (make-PycAssert loc %info need-return test msg))

;; (new-PycUninit loc #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycUninit loc #!key (%info #f) (type (quote unknown)))
   (make-PycUninit loc %info type))

;; (new-PycLiteralValue loc val #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycLiteralValue loc val #!key (%info #f) (type (quote unknown)))
   (make-PycLiteralValue loc %info type val))

;; (new-PycBool loc val #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycBool loc val #!key (%info #f) (type (quote unknown)))
   (make-PycBool loc %info type val))

;; (new-PycNone loc val #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycNone loc val #!key (%info #f) (type (quote unknown)))
   (make-PycNone loc %info type val))

;; (new-PycNumber loc val #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycNumber loc val #!key (%info #f) (type (quote unknown)))
   (make-PycNumber loc %info type val))

;; (new-PycString loc val #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycString loc val #!key (%info #f) (type (quote unknown)))
   (make-PycString loc %info type val))

;; (new-PycUnary loc op expr #!key (%info #f) (type (quote unknown)) (type-hint #f) (cache #f))
(define-inline (new-PycUnary loc op expr #!key (%info #f) (type (quote unknown)) (type-hint #f) (cache #f))
   (make-PycUnary loc %info type op expr type-hint cache))

;; (new-PycBinary loc op lhs rhs #!key (%info #f) (type (quote unknown)) (lhs-type-hint #f) (rhs-type-hint #f) (cache #f))
(define-inline (new-PycBinary loc op lhs rhs #!key (%info #f) (type (quote unknown)) (lhs-type-hint #f) (rhs-type-hint #f) (cache #f))
   (make-PycBinary loc %info type op lhs rhs lhs-type-hint rhs-type-hint cache))

;; (new-PycChainCmp loc ops lhs rest #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycChainCmp loc ops lhs rest #!key (%info #f) (type (quote unknown)))
   (make-PycChainCmp loc %info type ops lhs rest))

;; (new-PycBoolOp loc op args #!key (%info #f) (type (quote unknown)) (cache #f))
(define-inline (new-PycBoolOp loc op args #!key (%info #f) (type (quote unknown)) (cache #f))
   (make-PycBoolOp loc %info type op args cache))

;; (new-PycFun loc args posonlyargs vararg kwonlyargs kw-defaults kwarg defaults body #!key (%info #f) (type (quote unknown)) (decorators (quote ())) (decls (quote ())) (generator #f) (need-return #f) (can-locals #t) (super-in-class #f) (use-simple-scoping #f) (name #f) (annotation-names (quote ())) (annotation (quote ())) (is-builtin #f) (is-private #f) (&proc #f) (&proc-init #f))
(define-inline (new-PycFun loc args posonlyargs vararg kwonlyargs kw-defaults kwarg defaults body #!key (%info #f) (type (quote unknown)) (decorators (quote ())) (decls (quote ())) (generator #f) (need-return #f) (can-locals #t) (super-in-class #f) (use-simple-scoping #f) (name #f) (annotation-names (quote ())) (annotation (quote ())) (is-builtin #f) (is-private #f) (&proc #f) (&proc-init #f))
   (make-PycFun loc %info type args posonlyargs vararg kwonlyargs kw-defaults kwarg defaults body decorators decls generator need-return can-locals super-in-class use-simple-scoping name annotation-names annotation is-builtin is-private &proc &proc-init))

;; (new-PycSemantics loc args posonlyargs vararg kwonlyargs kw-defaults kwarg defaults body #!key (%info #f) (type (quote unknown)) (decorators (quote ())) (decls (quote ())) (generator #f) (need-return #f) (can-locals #t) (super-in-class #f) (use-simple-scoping #f) (name #f) (annotation-names (quote ())) (annotation (quote ())) (is-builtin #f) (is-private #f) (&proc #f) (&proc-init #f) (inline #f) (inline-as-is #f))
(define-inline (new-PycSemantics loc args posonlyargs vararg kwonlyargs kw-defaults kwarg defaults body #!key (%info #f) (type (quote unknown)) (decorators (quote ())) (decls (quote ())) (generator #f) (need-return #f) (can-locals #t) (super-in-class #f) (use-simple-scoping #f) (name #f) (annotation-names (quote ())) (annotation (quote ())) (is-builtin #f) (is-private #f) (&proc #f) (&proc-init #f) (inline #f) (inline-as-is #f))
   (make-PycSemantics loc %info type args posonlyargs vararg kwonlyargs kw-defaults kwarg defaults body decorators decls generator need-return can-locals super-in-class use-simple-scoping name annotation-names annotation is-builtin is-private &proc &proc-init inline inline-as-is))

;; (new-PycClass loc name module bases body #!key (%info #f) (type (quote unknown)) (decorators (quote ())) (decls (quote ())) (super-key (quote _)) (is-builtin #f) (is-private #f))
(define-inline (new-PycClass loc name module bases body #!key (%info #f) (type (quote unknown)) (decorators (quote ())) (decls (quote ())) (super-key (quote _)) (is-builtin #f) (is-private #f))
   (make-PycClass loc %info type name module bases body decorators decls super-key is-builtin is-private))

;; (new-PycYield loc val #!key (%info #f) (type (quote unknown)) (generator #f))
(define-inline (new-PycYield loc val #!key (%info #f) (type (quote unknown)) (generator #f))
   (make-PycYield loc %info type val generator))

;; (new-PycKont loc params body #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycKont loc params body #!key (%info #f) (type (quote unknown)))
   (make-PycKont loc %info type params body))

;; (new-PycCallKont loc kont #!key (%info #f) (type (quote unknown)) (args (quote ())))
(define-inline (new-PycCallKont loc kont #!key (%info #f) (type (quote unknown)) (args (quote ())))
   (make-PycCallKont loc %info type kont args))

;; (new-PycCall loc fun args #!key (%info #f) (type (quote unknown)) (keywords-values (quote ())) (keywords-names (quote ())) (can-be-super #t))
(define-inline (new-PycCall loc fun args #!key (%info #f) (type (quote unknown)) (keywords-values (quote ())) (keywords-names (quote ())) (can-be-super #t))
   (make-PycCall loc %info type fun args keywords-values keywords-names can-be-super))

;; (new-PycList loc elts #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycList loc elts #!key (%info #f) (type (quote unknown)))
   (make-PycList loc %info type elts))

;; (new-PycTuple loc elts #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycTuple loc elts #!key (%info #f) (type (quote unknown)))
   (make-PycTuple loc %info type elts))

;; (new-PycDict loc elts keys #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycDict loc elts keys #!key (%info #f) (type (quote unknown)))
   (make-PycDict loc %info type elts keys))

;; (new-PycSet loc elts #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycSet loc elts #!key (%info #f) (type (quote unknown)))
   (make-PycSet loc %info type elts))

;; (new-PycImport loc path from-list depth #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycImport loc path from-list depth #!key (%info #f) (type (quote unknown)))
   (make-PycImport loc %info type path from-list depth))

;; (new-PycIntrinsics loc id #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycIntrinsics loc id #!key (%info #f) (type (quote unknown)))
   (make-PycIntrinsics loc %info type id))

;; (new-PycStatic loc id value #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycStatic loc id value #!key (%info #f) (type (quote unknown)))
   (make-PycStatic loc %info type id value))

;; (new-PycStaticSexp loc id value #!key (%info #f) (type (quote unknown)))
(define-inline (new-PycStaticSexp loc id value #!key (%info #f) (type (quote unknown)))
   (make-PycStaticSexp loc %info type id value))

