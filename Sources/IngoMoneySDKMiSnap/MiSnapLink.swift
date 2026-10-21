// IngoMoneySDKMiSnap — links MiSnap alongside the Ingo binaries (no public API).
//
// A binary target can't declare dependencies of its own, so this small target pulls Mitek's MiSnap
// and MiSnapUX into the package's link graph. You never import this module directly — `import IngoSdk`.
import MiSnap
import MiSnapUX
