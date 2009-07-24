From: Guilherme Longo <grlongo.ireland@gmail.com>
Subject: snd_pcm_hw_params _set_period_time_near
Date: Thu, 23 Jul 2009 21:12:54 -0300
Message-ID: <4A68FC86.1060701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id C32A2103A24
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 02:13:10 +0200 (CEST)
Received: by qyk15 with SMTP id 15so1629569qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 17:13:09 -0700 (PDT)
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

Mates, I can=B4t find the real meaning of this function.
At first I thought that it was used to set the time between 2 =

consecutive samples, but it is not.

Does anyone could gimme some help with that?
Tks
