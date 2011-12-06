From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v3 0/6] core: add compress data API to ALSA
	kernel
Date: Tue, 6 Dec 2011 12:57:54 +0530
Message-ID: <CABb+yY0sh6oMD+C7Uj9D4A_XyL4XBL3YQOxyjkx0v5D7JMiNVQ@mail.gmail.com>
References: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
	<1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 62AF8103B45
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 08:27:55 +0100 (CET)
Received: by eekd17 with SMTP id d17so168077eek.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 23:27:55 -0800 (PST)
In-Reply-To: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Vinod,

On Mon, Dec 5, 2011 at 1:09 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> As agreed during the ASoC workshop in May 2011, this set of patches are a
> proposal from Intel to add a new compressed data interface to ALSA. This
> proposal builds on the existing Intel solution and the experience gathered over
> two years with Meego and Android solutions. This proposal is no longer
> Intel-specific and was generalized with the addition of a basic core;
> codec-related definitions are based on the vendor-neutral OpenMAX AL standard.
>
Is the layer, below this API, available somewhere to see the whole picture ?

Thanks,
Jassi
