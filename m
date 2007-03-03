From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [PATCH] intel8x0: add NVidia MPC55 support
Date: Sat, 3 Mar 2007 14:15:18 -0500
Message-ID: <75b66ecd0703031115r59adc353j3b649abd77ee16e0@mail.gmail.com>
References: <20070303190901.GA22328@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070303190901.GA22328@trinity.fluff.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/3/07, Ben Dooks <ben-alsa@fluff.org> wrote:
> Add the PCI-ID for the NVidia MPC55 HDA audio controller
> to the intel8x0 driver.
>
> Tested with 2 channel audio only.
>

If this is really an HDA device shouldn't it be supported by
snd-intel-hda rather than snd-intel8x0?

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
