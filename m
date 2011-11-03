From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: Using 2 codecs together in a system
Date: Thu, 3 Nov 2011 19:25:37 +0530
Message-ID: <CAODvfaE-=DeHiviyszydT-5z7C9LbtHckGG7mqq9Y8X1vku8-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 64F8C2413B
	for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2011 14:55:42 +0100 (CET)
Received: by ywp31 with SMTP id 31so1594517ywp.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Nov 2011 06:55:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

We have interfaced DM368 processor with one external codec and also to
the internal codec.
I am working on voip phone.

we have interfaced the Internal codec to Cradle. i.e., Cradle Mic and
Cradle Spk to the Internal codec

and

External codec.to the Handsfree mode.

Is it possible to switch dynamically between the codecs (Internal and
External) when user chooses Cradle and after sometime Handsfree vice
versa.

If so could you please put some light on this topic how this can be implemented.
what changes i need to do to my code to make this work. if any
reference code is available please suggest.

Thank you in advance,
Sreedhar
