From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] TXx9: Add ACLC support
Date: Sat, 16 May 2009 00:14:54 +0900 (JST)
Message-ID: <20090516.001454.193872890.anemo@mba.ocn.ne.jp>
References: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
	<alpine.LRH.2.00.0905151516300.32617@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 69BF4103991
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 17:14:55 +0200 (CEST)
In-Reply-To: <alpine.LRH.2.00.0905151516300.32617@vixen.sonytel.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geert.Uytterhoeven@sonycom.com
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Fri, 15 May 2009 15:45:36 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > Add platform support for ACLC of TXx9 SoCs.
> 
> I gave it a try on my RBTX4927, and after some fight^H^H^H^H^Hplaying with the
> alsa tools, I could play sound using `speaker-test --test wav --channels 2'!

Good news!  Thanks for your trial.

---
Atsushi Nemoto
