From: Patrick Boettcher <patrick.boettcher@desy.de>
Subject: Re: DigiDesign MBox USB Audio device
Date: Tue, 6 Apr 2004 00:17:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404060012340.20587@pub2.ifh.de>
References: <Pine.LNX.4.58.0404041840230.21649@pub2.ifh.de>    
 <Pine.HPX.4.33n.0404051750110.25421-100000@studcom.urz.uni-halle.de>
 <20040405215211.GB554@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040405215211.GB554@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi martin,

On Mon, 5 Apr 2004, Martin Langer wrote:
> Check the log of the init phase. Perhaps the MBox needs a firmware download
> at first.

I don't think so, as I wrote in the last answer to Clemens, the owner
told, me that he has to do a static firmware update (like a bios update).

And the usbsnoop logs only grow, when I play a sound. After pluging the
device in, only the configuration of the second interface is done, but no
(extra) data is transferred.

I will try to play a very short wave file and put the logfile on some
webspace.

best regards,
Patrick


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
