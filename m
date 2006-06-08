From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Creative's X-Fi plans
Date: Thu, 08 Jun 2006 15:37:36 -0400
Message-ID: <1149795457.3894.59.camel@mindpipe>
References: <1149791832.3894.39.camel@mindpipe>
	<1149794371.4886.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1149794371.4886.6.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Peter Zubaj <pzubaj@gaya.sk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-06-08 at 21:19 +0200, Peter Zubaj wrote:
> On Thu, 2006-06-08 at 14:37 -0400, Lee Revell wrote:
> > How could this possibly be legal?  The alsa-kernel middle layer is GPL!
> 
> They don't need this.
> They can have their own kernel driver and kernel API. Everything other
> can be alsa-lib plugin. And alsa-lib is LGPL.

But it would still be a derived work of the kernel.  AFAICT the only
legal way is to make a GPL wrapper around their Windows driver like
Nvidia.

Lee
