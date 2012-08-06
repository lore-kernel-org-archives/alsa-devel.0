From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v8] media: Add stk1160 new driver
Date: Mon, 6 Aug 2012 16:18:56 +0200
Message-ID: <201208061618.56479.hverkuil@xs4all.nl>
References: <1344260302-28849-1-git-send-email-elezegarcia@gmail.com>
 <CALF0-+Xwa6qNH3pEOgJq9f07C+ArNco6nxQcjGWoy5kwyQeScA@mail.gmail.com>
 <501FCFE1.7010802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr8.xs4all.nl (smtp-vbr8.xs4all.nl [194.109.24.28])
 by alsa0.perex.cz (Postfix) with ESMTP id CC66D265B61
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 15:49:13 +0200 (CEST)
In-Reply-To: <501FCFE1.7010802@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, Ezequiel Garcia <elezegarcia@gmail.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, alsa-devel@alsa-project.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon August 6 2012 16:08:33 Mauro Carvalho Chehab wrote:
> Em 06-08-2012 10:58, Ezequiel Garcia escreveu:
> > Hi Mauro,
> > 
> > On Mon, Aug 6, 2012 at 10:38 AM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> >> This driver adds support for stk1160 usb bridge as used in some
> >> video/audio usb capture devices.
> >> It is a complete rewrite of staging/media/easycap driver and
> >> it's expected as a replacement.
> >> ---
> >>
> > 
> > I just sent v8, but it looks it wasn't received by patchwork either.
> > 
> > What's going on?
> 
> The patch didn't arrive at linux-media ML.
> 
> Not sure why it got rejected at vger. I suggest you to ping vger admin
> to see why your patches are being rejected there.
> 
> I tested parsing this patch manually and patchwork accepted. So, once
> the issue with vger is solved, other patches should be properly
> handled there.

Could it be related to the fact that a gmail account is used? Konke Radlow
had a similar issue recently when he posted a patch from a gmail account. It
worked fine when posted from a company account.

Regards,

	Hans
