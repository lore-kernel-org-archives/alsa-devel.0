From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: ymfpci : four speakers with OSS-emulation
Date: Thu, 14 Mar 2002 07:43:31 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10203140738390.6652-100000@sorrow.ashke.com>
References: <s5h3cz3jxei.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <s5h3cz3jxei.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Thu, 14 Mar 2002, Takashi Iwai wrote:

> 
> what shows with -v option?
> can you hear from rear speakers when you play with -Drear ?
> 
> 
> Takashi
> 

Takashi,

	My apologies, but for some reason I had "surround" muted in
alsamixer.  Once I unmuted it, I *am* getting the duplicate sound on the
rear speakers.

	So now, is it likely that we'll see the ymfpci driver changed at
some point so that we can use both the front and rear speakers so that
they don't duplicate each other (as I described in my message yesterday)?
:-)

Adam




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
