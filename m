From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v4 2/3] ASoC: OMAP4: Add support for McPDM
Date: Tue, 23 Feb 2010 10:13:39 +0000
Message-ID: <1266920019.3156.5.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8FA52BF5@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 69BF91038BE
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 11:13:43 +0100 (CET)
Received: by fxm20 with SMTP id 20so8707098fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 02:13:43 -0800 (PST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8FA52BF5@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-02-22 at 17:17 -0600, Candelaria Villareal, Jorge wrote:
> McPDM is the interface between Phoenix audio codec
> and the OMAP4430 processor. It enables data to be transfered
> to/from Phoenix at sample rates of 88.4 or 96 KHz.
> 
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya <x0080101@ti.com>
> ---
> 
> Resending patch to fix an issue reset_playback function
> 

In the future can you increment the patch version number. This way it
makes it easier to see that its different from the previous version.

Since all the previous V4 patches are acked. Can you send this as a diff
to the V4 version.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
