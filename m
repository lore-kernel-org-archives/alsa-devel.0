From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] alsa-driver-1.0.4rc1 missing snd-usb-usx2y ?
Date: Tue, 30 Mar 2004 09:35:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403300934470.1835@pnote.perex-int.cz>
References: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>       
 <200403292129.04497.annabellesgarden@yahoo.de>     
 <32817.192.168.1.5.1080596468.squirrel@www.rncbc.org>
 <32796.192.168.1.5.1080604301.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32796.192.168.1.5.1080604301.squirrel@www.rncbc.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Mar 2004, Rui Nuno Capela wrote:

> Hi,
> 
> Just checked out 1.0.4rc1 a few moments ago and I'm already missing the
> snd-usb-usx2y module. AFAICT it's not being included by
> ./configure --with-cards option, nor it gets built when one sets
> --with-cards=all.

It is fixed in CVS now. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
