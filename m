From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
Date: Thu, 03 Mar 2005 13:52:06 -0500
Message-ID: <1109875926.2908.26.camel@mindpipe>
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Canter <marcus@vfxcomputing.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-03-03 at 13:46 -0500, Mark Canter wrote:
> The same issue exists on a T42p (ICH4).  Doesn't that kind of defeat the 
> purpose?  The thought of having to disable the headphone jack and reenable 
> it each time is trivial considering you can go with the fact that sound 
> did not require the sound system touched under <= 2.6.10.

You don't have to disable and re-enable it each time, if your system is
configured correctly then your mixer settings will be saved.

Lee
