From: Anthony <avan@uwm.edu>
Subject: Re: ice1712 noise
Date: Sat, 31 Jan 2004 13:57:52 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040131195752.GA4224@ice_nine.wi.rr.com>
References: <Pine.LNX.4.58.0401311125130.1876@pnote.perex-int.cz>
Reply-To: avan@uwm.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401311125130.1876@pnote.perex-int.cz>
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

* Jaroslav Kysela <perex@suse.cz> [Jan 31 04 13:16]:
> It looks like that something is wrong with DACs.                            
> Does the noise occur on all outputs?                                         
>                                                                              
>                                       Jaroslav                               

I hope not! I think it occurs on all channels, but have
yet to reproduce it today to verify. I'm thinking about
installing a windows OS and testing there. I've also
noticed immediately after upgrading to 1.0.2 that I get
occasional drop outs on playback...they are not xruns,
at least they dont sound as harsh and jackd doesn't
report them - just an instant of silence.

--ant


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
