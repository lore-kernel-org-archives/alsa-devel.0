From: "Jack O'Quin" <joq@io.com>
Subject: Re: 2.6.0-test11
Date: 01 Dec 2003 13:49:08 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87smk4pbd7.fsf@sulphur.joq.us>
References: <Pine.HPX.4.33n.0312011002010.24218-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0312011002010.24218-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


> Apostolos Dimitromanolakis wrote:
> > I noticed that the newest alsa driver has not yet found it's way to the
> > 2.6 kernel tree.. I hope it does before the official 2.6.0 release.

These lists naturally contain lots of messages about things not
working.  So, I'd like to report that my experience with 2.6.0-test11
and ALSA was completely successful.  I downloaded the sources,
configured them, selected my ALSA drivers, compiled, installed,
rebooted, and (*gasp*) everything worked fine!

So, a big "well done" to the ALSA developers.  This is significant
milestone, years in the making.  You deserve all our thanks.

Clemens Ladisch <clemens@ladisch.de> writes:

> It has been too late for anything but important bugfixes quite some
> time now.  The latest ALSA won't be in 2.6.0, but in 2.6.1.
> 
> Linus wrote in the -test11 announcement:
> | Please don't even bother sending me patches, because I'll be
> | stuffing my face away from email over the next few days. And after
> | that it will be up to Andrew to say how to go on from here.

Linus is right about this.  Problems in ALSA can be fixed in CVS and
released in 2.6.[12345].  No one should get hung up by that.  Right
now, 2.6.0 needs stability.

Regards,
-- 
  Jack O'Quin
  Austin, Texas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
