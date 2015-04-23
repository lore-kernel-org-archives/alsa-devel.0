From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-bebob and PrismSound Orpheus fails
	with	snd_pcm_hw_params_set_channels
Date: Thu, 23 Apr 2015 16:39:16 +0200
Message-ID: <55390414.8000502@ladisch.de>
References: <CAJ0eYfWsg3TNER07ENFg+z2nPgD_Wd50Gtt5HiJNdbZfDcKodQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1E74A261AF0
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:39:20 +0200 (CEST)
In-Reply-To: <CAJ0eYfWsg3TNER07ENFg+z2nPgD_Wd50Gtt5HiJNdbZfDcKodQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Ood <jh1ood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mike Ood wrote:
> % aplay -D plughw:2 test.wav
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> aplay: set_params:1297: Unable to install hw params:

Any error message in the system log?


Regards,
Clemens
