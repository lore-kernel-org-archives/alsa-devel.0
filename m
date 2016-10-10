From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Audio on mx6q udoo
Date: Mon, 10 Oct 2016 17:41:49 -0300
Message-ID: <CAOMZO5Dco0sYZ5VHqMuG0FB=4meQNm7qkYJ7b0wXNBTjLPUxuA@mail.gmail.com>
References: <CAOMZO5DdwgYBbOG7sik-Wc34zEqfttOc3EZwsisFgzwtcbDPNA@mail.gmail.com>
 <57F6644F.3070500@maciej.szmigiero.name>
 <CAOMZO5DtJG6Otw8rfZQQymsoZJ4UhB2idgDCXgWN69OMyQc_Ww@mail.gmail.com>
 <57F6D452.3020306@maciej.szmigiero.name>
 <CAOMZO5DPCBquq3m61nxvjaQ0=Lg9wsytn4aW_+YF89cbd5dCYA@mail.gmail.com>
 <57F6DB8F.80605@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com
 [209.85.213.52])
 by alsa0.perex.cz (Postfix) with ESMTP id CAAF82665E5
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2016 22:41:51 +0200 (CEST)
Received: by mail-vk0-f52.google.com with SMTP id 192so1017974vkl.2
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2016 13:41:51 -0700 (PDT)
In-Reply-To: <57F6DB8F.80605@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

On Thu, Oct 6, 2016 at 8:17 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> If I remember correctly I had some problem if SDMA driver was built-in
> into kernel (it didn't load firmware correctly or so).
> Not sure that the problem was with sound but maybe this is worth checking.

I am not loading any external SDMA firmware.

Haven't had a chance to try your config yet, but will investigate on
the SDMA module versus built-in and also about the SDMA firmware.

Thanks
