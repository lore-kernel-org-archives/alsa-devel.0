From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: jack plugin?
Date: Mon, 3 Nov 2003 20:55:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031103205511.70424346.mista.tapas@gmx.net>
References: <20031027175032.1d0760f3.mista.tapas@gmx.net>
	<s5h7k2p61f1.wl@alsa2.suse.de>
	<s5hekwx44ht.wl@alsa2.suse.de>
	<s5hbrs1443p.wl@alsa2.suse.de>
	<20031028210623.36867d0d.mista.tapas@gmx.net>
	<20031029003739.6b69b361.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031029003739.6b69b361.mista.tapas@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 29 Oct 2003 00:37:39 +0100
Florian Schmidt <mista.tapas@gmx.net> wrote:

> and i got aplay to play over it [using the jackplug as defined in the
> example .asoundrc]. But here the sound is heavily distorted [sounds
> like constant buffer underruns] and produces loads of text like
> this[1]:
> 
> I also could set the alsa outputplugin of xmms to jackplug, and it
> seemed to play. at first it played silence and then after some tries
> it played noise [a humming noise]..


One last thought on the issue [couldn't get it to work reliable]. I have
jack installed in /usr/local while all the alsa stuff i put into /usr.
Could this be part of the problem?

FLorian Schmidt


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
