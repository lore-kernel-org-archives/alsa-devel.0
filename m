From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix register programming in
	Freescale	MPC8610 HPCD sound driver
Date: Fri, 13 Jun 2008 20:34:27 +0100
Message-ID: <1213385667.6376.0.camel@odin>
References: <1213383751-17284-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C81C0244EC
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 21:34:23 +0200 (CEST)
In-Reply-To: <1213383751-17284-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-06-13 at 14:02 -0500, Timur Tabi wrote:
> Fix the Freescale MPC8610 HPCD sound driver so that it programs the DMACR
> and PMUXCR registers in the global utilities correctly.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
