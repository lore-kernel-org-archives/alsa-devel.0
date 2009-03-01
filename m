From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fix typo and removed unneeded switch case
Date: Sat, 28 Feb 2009 19:11:02 -0600
Message-ID: <ed82fe3e0902281711u52dfcc1bp13e23ade51058cfe@mail.gmail.com>
References: <ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
	<1235823663-9023-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 927372415F
	for <alsa-devel@alsa-project.org>; Sun,  1 Mar 2009 02:11:03 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 5so1518048qwf.56
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 17:11:02 -0800 (PST)
In-Reply-To: <1235823663-9023-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 28, 2009 at 6:21 AM, Daniel Mack <daniel@caiaq.de> wrote:
> This removes a misspelled comment and got rid of superfluous switch
> case.
>
> Cc: Timur Tabi <timur@freescale.com>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

Acked-by: Timur Tabi <timur@freescale.com>

Mark, please add "cs4270:" to the summary when you commit this patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
