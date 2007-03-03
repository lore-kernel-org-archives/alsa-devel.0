From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH] intel8x0: add NVidia MPC55 support
Date: Sat, 3 Mar 2007 19:16:56 +0000
Message-ID: <20070303191656.GA22386@trinity.fluff.org>
References: <20070303190901.GA22328@trinity.fluff.org>
	<75b66ecd0703031115r59adc353j3b649abd77ee16e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <75b66ecd0703031115r59adc353j3b649abd77ee16e0@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ben Dooks <ben-alsa@fluff.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 03, 2007 at 02:15:18PM -0500, Lee Revell wrote:
> On 3/3/07, Ben Dooks <ben-alsa@fluff.org> wrote:
> > Add the PCI-ID for the NVidia MPC55 HDA audio controller
> > to the intel8x0 driver.
> >
> > Tested with 2 channel audio only.
> >
> 
> If this is really an HDA device shouldn't it be supported by

Ah, totally missed that driver. Yes, it is already in there

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
