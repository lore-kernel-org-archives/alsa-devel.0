From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH v8] media: Add stk1160 new driver
Date: Mon, 06 Aug 2012 11:08:33 -0300
Message-ID: <501FCFE1.7010802@redhat.com>
References: <1344260302-28849-1-git-send-email-elezegarcia@gmail.com>
 <CALF0-+Xwa6qNH3pEOgJq9f07C+ArNco6nxQcjGWoy5kwyQeScA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 50109265B61
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 15:38:51 +0200 (CEST)
In-Reply-To: <CALF0-+Xwa6qNH3pEOgJq9f07C+ArNco6nxQcjGWoy5kwyQeScA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>, alsa-devel@alsa-project.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 06-08-2012 10:58, Ezequiel Garcia escreveu:
> Hi Mauro,
> 
> On Mon, Aug 6, 2012 at 10:38 AM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
>> This driver adds support for stk1160 usb bridge as used in some
>> video/audio usb capture devices.
>> It is a complete rewrite of staging/media/easycap driver and
>> it's expected as a replacement.
>> ---
>>
> 
> I just sent v8, but it looks it wasn't received by patchwork either.
> 
> What's going on?

The patch didn't arrive at linux-media ML.

Not sure why it got rejected at vger. I suggest you to ping vger admin
to see why your patches are being rejected there.

I tested parsing this patch manually and patchwork accepted. So, once
the issue with vger is solved, other patches should be properly
handled there.

Regards,
Mauro
