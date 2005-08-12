From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [linux-audio-dev] Re: any update on
	the	pcmcia bug blocking Audigy2 notebook sound card driver development
Date: Fri, 12 Aug 2005 12:03:08 -0400
Message-ID: <1123862588.12680.12.camel@mindpipe>
References: <1ed860e3050807084449b0daac@mail.gmail.com>
	 <20050807104332.320aec48.akpm@osdl.org>
	 <1123519224.16205.5.camel@cmn37.stanford.edu>
	 <1123570490.26998.1.camel@mindpipe> <s5hvf2eyvme.wl%tiwai@suse.de>
	 <42F9D574.1090508@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42F9D574.1090508@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>, Raymond Lai <raymond.kk.lai@gmail.com>, linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-08-10 at 11:22 +0100, James Courtier-Dutton wrote:
> It is still a PCMCIA cardbus bug in the kernel that is the real cause. I 
> have had very little time recently to look at it. It is extremely 
> difficult to track down the reason for this bug, so I think that fixing 
> this is a long way away at present.

Well the LKML thread ended (before OLS) with the kernel developers
asking you for /proc/ioports and other info and I never saw it.  Maybe
we will get lucky and they'll be able to fix it quickly.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
