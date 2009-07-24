From: Guilherme Raymo Longo <grlongo.ireland@gmail.com>
Subject: snd_pcm_hw_params_set_period_time_near
Date: Fri, 24 Jul 2009 12:00:00 -0300
Message-ID: <fa40cc720907240800ne4734fbs73ca8ea568804f91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F32F24622
	for <Alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 17:00:02 +0200 (CEST)
Received: by bwz26 with SMTP id 26so102116bwz.32
	for <Alsa-devel@alsa-project.org>; Fri, 24 Jul 2009 08:00:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mates, I can=B4t find the real meaning of this function.
snd_pcm_hw_params_set_period_time_near
At first I thought that it was used to set the time between 2 consecutive
samples, but it is not.

Does anyone could gimme some help with that?
Tks
