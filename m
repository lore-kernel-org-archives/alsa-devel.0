From: Ed Sweetman <safemode@speakeasy.net>
Subject: Re: BUG, minor in alsamixer
Date: 30 Jun 2002 21:39:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1025487597.28736.117.camel@psuedomode>
References: <20020701002407.31081.qmail@web14106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020701002407.31081.qmail@web14106.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Dave Andruczyk <djandruczyk@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2002-06-30 at 20:24, Dave Andruczyk wrote:
> 
> On my system with ALSA 0.9rc2 (driver, libs, utils) firing up alsamixer in an
> xterm. (standard xterm, Xfree-4.2.0) hitting the arrow keys to select the
> desired slider results in it quitting immediately.  I have to hit the spacebar
> at least once, and then things work as normal.  this was also a problem in RC1,
> but an older edition DID NOT have this issue.
> 
> 
> Any ideas? (is this a feature?)

Also occured with me, the terminal has nothing to do with it.  I use it
in Eterms.   It doesn't do that anymore though...only for a while with
some earlier cvs version of alsa.   I suggest updating to the latest cvs
if you haven't already.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
