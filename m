From: Stumbles <dveatch@woh.rr.com>
Subject: Re: 0.9.7c, cs4236b and kernel oops
Date: Thu, 16 Oct 2003 08:46:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310160846.38089.dveatch@woh.rr.com>
References: <200310142124.56447.dveatch@woh.rr.com> <s5h65ipig02.wl@alsa2.suse.de> <s5h3cdtif6m.wl@alsa2.suse.de>
Reply-To: dveatch@woh.rr.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cdtif6m.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 16 October 2003 07:40 am, Takashi Iwai wrote:
> At Thu, 16 Oct 2003 13:22:37 +0200,
>
> I wrote:
> > could you try the attached patch?
>
> found one more potential bug.  use this one instead.
>
>
> Takashi

Glad I waited. Is it, move to /usr/src/alsa-driver-0.9.7c/support/pnp and 
"patch -p1 < file"? Another dumb question, how do I get patch not to ask 
about skipping it and do it anyway? The reason is I have a script that 
automates the build.


-- 
Registered Linux user 193414
http://counter.li.org

"Trying"? My contribution was much closer to a "feeble wave in the general 
direction of something that might lead you one step closer to a solution 
if you squint really hard and do all of the work."



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
