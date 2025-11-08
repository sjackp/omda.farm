import { Redirect, Route, Switch } from 'wouter'
import { useAuth } from './providers/AuthProvider'
import Login from './pages/Login'
import { Layout } from './app/Layout'
import Dashboard from './pages/Dashboard'
import Herd from './pages/Herd'
import Groups from './pages/Groups'
import Group from './pages/Group'
import Feed from './pages/Feed'
import Sales from './pages/Sales'
import Expenses from './pages/Expenses'
import Finance from './pages/Finance'
import Weights from './pages/Weights'
import Cycle from './pages/Cycle'
import Settings from './pages/Settings'
import Cow from './pages/Cow'
import Vaccines from './pages/Vaccines'

export default function AppRoutes() {
  const { user, status } = useAuth()

  if (status === 'loading') {
    return (
      <div className="min-h-screen flex items-center justify-center bg-slate-100 dark:bg-slate-950">
        <p className="text-sm text-slate-600 dark:text-slate-300">Checking session…</p>
      </div>
    )
  }

  if (!user) {
    return (
      <Switch>
        <Route path="/login" component={Login} />
        <Route>
          <Redirect to="/login" />
        </Route>
      </Switch>
    )
  }

  return (
    <Layout>
      <Switch>
        <Route path="/login">
          <Redirect to="/" />
        </Route>
        <Route path="/" component={Dashboard} />
        <Route path="/herd" component={Herd} />
        <Route path="/groups" component={Groups} />
        <Route path="/groups/:id">{(params) => <Group id={Number(params.id)} />}</Route>
        <Route path="/feed" component={Feed} />
        <Route path="/vaccines" component={Vaccines} />
        <Route path="/weights" component={Weights} />
        <Route path="/sales" component={Sales} />
        <Route path="/expenses" component={Expenses} />
        <Route path="/finance" component={Finance} />
        <Route path="/cycle" component={Cycle} />
        <Route path="/settings" component={Settings} />
        <Route path="/cow/:id">{(params) => <Cow id={Number(params.id)} />}</Route>
        <Route>
          <Redirect to="/" />
        </Route>
      </Switch>
    </Layout>
  )
}


