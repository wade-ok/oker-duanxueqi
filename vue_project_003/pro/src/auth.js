import Cookies from 'js-cookie'
const TokenKey ='UserToken'

export function setUser(token)
  {
 
    Cookies.set(TokenKey,token)

  }
export function getUser()
{
  return{
    token:Cookies.get(TokenKey)
  }
}