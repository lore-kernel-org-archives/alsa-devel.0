From: Glenn Maynard <glenn@zewt.org>
Subject: Re: Q: Periodsize for capture, SBLive
Date: Mon, 18 Oct 2004 15:52:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018195249.GH9692@zewt.org>
References: <20041018133613.GA14810@stud.ntnu.no> <200410181342.i9IDgC44003811@localhost.localdomain> <20041018142229.GA26466@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20041018142229.GA26466@stud.ntnu.no>
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

On Mon, Oct 18, 2004 at 04:22:29PM +0200, alsa-devel-admin@lists.sourceforge.net wrote:
> On Mon, Oct 18, 2004 at 09:42:11AM -0400, Paul Davis wrote:
> > >I open the sound card (a SoundBlaster Live) for capture, and
> > >request a period size (using set_period_size_near()) of 8 frames,
> > >but what I get is a period size of 384 frames.
> > 
> > the SBlive can't go below 64 at best. 
> 
> OK.  Any idea why I get 384?

This message appears to be missing a From: header.  (That's strange,
since most MUAs will forcibly add one.  You might want to check your
mailer.

-- 
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
