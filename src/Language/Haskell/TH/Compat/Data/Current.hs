module Language.Haskell.TH.Compat.Data.Current (
  dataD', unDataD,
  newtypeD', unNewtypeD,
  dataInstD', unDataInstD,
  newtypeInstD', unNewtypeInstD,
  ) where

import Language.Haskell.TH
  (CxtQ, ConQ, TypeQ, DecQ,
   Cxt, Con, Type, Name, TyVarBndr, Kind,
   Dec (DataD, NewtypeD, DataInstD, NewtypeInstD),
   dataD, newtypeD, dataInstD, newtypeInstD, conT)


-- | Definition against 'dataD',
--   compatible with before temaplate-haskell-2.11
dataD' :: CxtQ -> Name -> [TyVarBndr] -> [ConQ] -> [Name]
       -> DecQ
dataD' cxt n bs cs ds = dataD cxt n bs Nothing cs $ mapM conT ds

-- | Compatible interface to destruct 'DataD'
unDataD :: Dec -> Maybe (Cxt, Name, [TyVarBndr], Maybe Kind, [Con], [Type])
unDataD (DataD cxt n bs mk cs ds) = Just (cxt, n, bs, mk, cs, ds)
unDataD  _                        = Nothing

-- | Definition against 'newtypeD',
--   compatible with before temaplate-haskell-2.11
newtypeD' :: CxtQ -> Name -> [TyVarBndr] -> ConQ -> [Name]
          -> DecQ
newtypeD' cxt n bs c ds = newtypeD cxt n bs Nothing c $ mapM conT ds

-- | Compatible interface to destruct 'NewtypeD'
unNewtypeD :: Dec -> Maybe (Cxt, Name, [TyVarBndr], Maybe Kind, Con, [Type])
unNewtypeD (NewtypeD cxt n bs mk c ds) = Just (cxt, n, bs, mk, c, ds)
unNewtypeD  _                          = Nothing

-- | Definition against 'dataInstD',
--   compatible with before temaplate-haskell-2.11
dataInstD' :: CxtQ -> Name -> [TypeQ] -> [ConQ] -> [Name]
           -> DecQ
dataInstD' cxt n as cs ds = dataInstD cxt n as Nothing cs $ mapM conT ds

-- | Compatible interface to destruct 'DataInstD'
unDataInstD :: Dec -> Maybe (Cxt, Name, [Type], Maybe Kind, [Con], [Type])
unDataInstD (DataInstD cxt n as mk cs ds) = Just (cxt, n, as, mk, cs, ds)
unDataInstD  _                            = Nothing

-- | Definition against 'newtypeInstD',
--   compatible with before temaplate-haskell-2.11
newtypeInstD' :: CxtQ -> Name -> [TypeQ] -> ConQ -> [Name]
              -> DecQ
newtypeInstD' cxt n as c ds = newtypeInstD cxt n as Nothing c $ mapM conT ds

-- | Compatible interface to destruct 'NewtypeInstD'
unNewtypeInstD :: Dec -> Maybe (Cxt, Name, [Type], Maybe Kind, Con, [Type])
unNewtypeInstD (NewtypeInstD cxt n as mk c ds) = Just (cxt, n, as, mk, c, ds)
unNewtypeInstD  _                              = Nothing
