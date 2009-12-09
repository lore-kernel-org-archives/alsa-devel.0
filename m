From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC: S3C64XX: Patches for reforming s3c64xx-i2s
 driver
Date: Wed, 09 Dec 2009 11:07:02 +0000
Message-ID: <1260356822.3614.112.camel@odin>
References: <1260332950-11352-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id F3B5D10381F
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:07:04 +0100 (CET)
Received: by ewy23 with SMTP id 23so6156722ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2009 03:07:04 -0800 (PST)
In-Reply-To: <1260332950-11352-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-12-09 at 13:29 +0900, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Hello,
>   I am going to submit some cleanup and reforming patches to enable the
> s3c64xx-i2s.c to become generic enough to handle I2S-v3 controllers of
> other SoCs as well.
>  
>  Testing for build after each patch has been success.

Had a quick scan and this series looks initially ok.

It has my 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk> 

if Ben and Mark are happy with it too.

Thanks

Liam
