From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: ATI IXP Modem driver
Date: Thu, 29 Jul 2004 19:27:39 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040729192739.4e73c7c3@sashak.lan>
References: <1083465072.1639.8.camel@server.gowanlea.net>
	<20040503163657.668357a9@sashak.lan>
	<1087962001.4844.0.camel@server.gowanlea.net>
	<20040711191833.462a0b4b@sashak.lan>
	<s5hr7rhcztt.wl@alsa2.suse.de>
	<20040712162839.2c58e1c3@sashak.lan>
	<s5hd631cq5v.wl@alsa2.suse.de>
	<20040712195450.04494434@sashak.lan>
	<s5hr7rhb1tx.wl@alsa2.suse.de>
	<20040725182154.3317e5d8@sashak.lan>
	<s5hbri014jy.wl@alsa2.suse.de>
	<s5hk6wmq24u.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6wmq24u.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: unixtricks@btinternet.com, alsa-devel@lists.sourceforge.net, Antonis Tsolomitis <atsol@aegean.gr>, Jacques Goldberg <Jacques.Goldberg@cern.ch>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Jul 2004 17:11:45 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > 
> > How about adding a new flag to ac97 struct to indicate the shared
> > chip type?
> 
> Ok, I changed the codes on CVS as the following patch.
> Can anyone try it out?

Works as expected with 'atiixp'. :)

Thanks,
Sasha.



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
