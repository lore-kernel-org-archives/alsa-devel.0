From: Cameron Hutchison <camh+alsa@xdna.net>
Subject: Re: ens1371/ac97 broken on my machine
Date: Mon, 16 Jun 2003 14:47:31 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030616044731.GA22395@imladris>
References: <20030521063408.GA11993@imladris> <s5hel2sva3q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hel2sva3q.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Once upon a time Takashi Iwai said...
> At Wed, 21 May 2003 16:34:08 +1000,
> Cameron Hutchison wrote:
> > 
> > The driver for the ens1371 chipset no longer works on my laptop.
> > It used to work in version 0.9.0rc3, but in version 0.9.2 and 0.93a, it
> > no longer works. When I try to run alsamixer, I get the error "No mixer
> > elems found"
> 
> i put a workaround code for ens1371 to avoid this.
> can you try the cvs version?

Ok. I finally got around to testing this again in the 0.9.4 release, and
I can report that it now works for me.

Thanks very much for your quick fix, and apologies for my slow response.




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
