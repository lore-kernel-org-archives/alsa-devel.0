From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: DMX6fire / ice1712: Long initialization time for
	playback with Java
Date: 02 Nov 2003 17:14:38 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067814879.32168.16.camel@eviltwin>
References: <3FA58135.8050907@gmx.de> <1067811778.32164.13.camel@eviltwin>
	<3FA5921F.8050804@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FA5921F.8050804@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steffen Sauder <steffensauder@gmx.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Not JavaSound, just the ice1712 with ALSA, JACK, Ardour, and JAMin.

Jan


On Sun, 2003-11-02 at 17:24, Steffen Sauder wrote:
> Jan Depner wrote:
> 
> >Just curious, but have you tried making sure that artsd is dead prior to
> >starting?  I only get these types of delays if I forget to kill it first
> >(an OS beep will start it).
> >
> >  
> >
> I have disabled the "start aRts soundserver on KDE startup" option, and 
> there is no artsd process running,
> so I think that arts can't be the cause.
> 
> Did you run my sample program or are you speaking of our experience with 
> JavaSound in general?
> 
> Steffen
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?   SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
