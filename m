From: Ramya Desai <ramya.desai@gmail.com>
Subject: Re: Linux USB audio driver - sample code / link /
	documentation
Date: Fri, 26 Nov 2010 15:00:52 +0530
Message-ID: <AANLkTind0TDg=gcE0Pfu2BDaadk64FKgvM-3SNVLcobd@mail.gmail.com>
References: <AANLkTi=R_2dPhOGCB+5Dv_KUG3PrESg+Z+x1A_bhiTjr@mail.gmail.com>
	<4CEF66FA.3090405@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ACD98103D00
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 10:30:53 +0100 (CET)
Received: by gyg8 with SMTP id 8so967981gyg.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 01:30:53 -0800 (PST)
In-Reply-To: <4CEF66FA.3090405@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2010 at 1:21 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Ramya Desai wrote:
>> I did not find a document for writing a USB audio driver under Linux
>> environment. Please let me know any sample driver / link / document
>> which describes about the USB audio driver under Linux environment.
>
> The simplest sample driver is this one:
> http://www.alsa-project.org/~clemens/ua1a.patch

Thank you very much for your link.

However, the source is also available at sound/usb/misc/ua101.c. What
is the difference between sound/usb/misc/ua101.c and your patch (in
the above link)?

Thanks and Regards,
Ramya.
