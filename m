From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: non-blocking mode example
Date: Sat, 12 Aug 2017 18:30:16 +0200
Message-ID: <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
References: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id F312D267028
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 18:30:50 +0200 (CEST)
Received: from [192.168.42.62] (tmo-111-14.customers.d1-online.com
 [80.187.111.14])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 5F2855581335
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 18:30:49 +0200 (CEST)
In-Reply-To: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ThomasJF wrote:
> could anyone please link me to or show me a small demo example, like
> "pcm_min.c" with working snd_pcm_open in SND_PCM_NONBLOCK - mode?

alsa-utils/alsaloop, but it's not quite small.


Regards,
Clemens
