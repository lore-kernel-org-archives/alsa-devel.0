From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Rear right speaker silent on 2.6.11
Date: Sat, 12 Mar 2005 18:45:17 -0500
Message-ID: <1110671117.13277.2.camel@mindpipe>
References: <4233770C.10601@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4233770C.10601@gentoo.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Drake <dsd@gentoo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-03-12 at 23:11 +0000, Daniel Drake wrote:
> Hi,
> 
> I'm using the onboard sound chip on my nvidia nforce motherboard with the 
> snd-intel8x0 driver. As of 2.6.11, the rear right speaker has gone silent (the 
> others are fine). Going back to 2.6.10 makes it all work again.
> 
> Upgrading to 2.6.11-mm3 solves the problem. But I'm interested in which patch 
> solves this problem, so that I can fix the Gentoo kernel.

Make sure you submit the patch to stable@kernel.org too so it can be
included in 2.6.11.x.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
