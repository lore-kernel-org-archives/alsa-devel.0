From: "vasudha rao" <vasudha.jrao@gmail.com>
Subject: arecord ..xrun!!!!
Date: Fri, 19 Dec 2008 18:34:08 +0530
Message-ID: <eeb9eca50812190504g6701afe8i2f6517179b72b74d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by alsa0.perex.cz (Postfix) with ESMTP id 2F288243D4
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 14:04:10 +0100 (CET)
Received: by ewy13 with SMTP id 13so1010814ewy.8
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 05:04:09 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi ..

I am trying to record .wav files..

I did like,
$arecord -D copy test.wav
Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
xrun!!! (at least 0.251 ms long)
xrun!!! (at least 0.071 ms long)
xrun!!! (at least 0.072 ms long)
.
.
.

When I run this test.wav, no sound!!!!

Am I doing wrong anywhere??

Thanks:-)
