From: Martin Langer <martin-langer@gmx.de>
Subject: Re: DigiDesign MBox USB Audio device
Date: Mon, 5 Apr 2004 23:52:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040405215211.GB554@tuba.home>
References: <Pine.LNX.4.58.0404041840230.21649@pub2.ifh.de> <Pine.HPX.4.33n.0404051750110.25421-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0404051750110.25421-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Patrick Boettcher <patrick.boettcher@desy.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 05, 2004 at 06:00:01PM +0200, Clemens Ladisch wrote:
> Patrick Boettcher wrote:
> > I'm using a usbsnoop program to do some basic sniffing. Logs are
> > really big :/.
> 
> Try to play some 0.01-seconds wave file, and don't connect any other
> USB devices.

Check the log of the init phase. Perhaps the MBox needs a firmware download
at first.


martin


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
