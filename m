From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Asus E35M1-M Pro and Realtek AL887-VD - no love
	from ALSA for Sourround
Date: Fri, 25 Mar 2011 08:24:10 +0800
Message-ID: <AANLkTimeuga435MzXu91xy-QvUJo2ZPRbF39Gb2_kxhm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1806524408
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 01:24:12 +0100 (CET)
Received: by fxm6 with SMTP id 6so627971fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 17:24:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> I recently purchased *Asus* *e35M1*-*M* *Pro* and I would like to get souround
>> sound going fro*m* *m*y 5.1 syste*m*. I have it connected accordingly to the
*>> m*anual (line in - rear speakers, line out - front speaker, *m*ic in -
>> bass/center) but anywy I try that is using guides like
>> http://www.gentoo-wiki.info/HOWTO_Surround_Sound <http://www.gentoo-wiki.info/HOWTO_Surround_Sound> I a*m* *no*t able to get
>> sound fro*m* any other speaker then front left and right one. *Alsa**m*ixer
>> does *no*t show any devices as shared to be available to switch to the
>> output fro*m* input

>> speaker-test plays every file in the left and right front speaker at the
>> sa*m*e ti*m*e

>> Here is *m*y syste*m* infor*m*ation using  2.6.38-rc8-git3
>> http://www.*alsa*-*pro*ject.org/db/?f=0dd55b4640a8afff1552c4d0be0105e416ad1cf3 <http://www.alsa-project.org/db/?f=0dd55b4640a8afff1552c4d0be0105e416ad1cf3>
>> and 2.6.38-rc8-next-20110314
>> http://www.*alsa*-*pro*ject.org/db/?f=a8733bf0083929540948f51b5f33d9c8a62d9994 <http://www.alsa-project.org/db/?f=a8733bf0083929540948f51b5f33d9c8a62d9994>

*>> M*y question is what should I try next?


Any desktop motherboard with 3 jacks in rear panel should use
"3stack-6ch" to support analog surround51

or "3stack-6ch-dig" to analog surround51 and digital out
