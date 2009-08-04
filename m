From: Guilherme Longo <grlongo.ireland@gmail.com>
Subject: Controling wave amplitude using alsa api !! (pcm
	interface ???????)
Date: Tue, 04 Aug 2009 13:38:03 -0300
Message-ID: <4A7863EB.5090207@gmail.com>
References: <eedb5540908040818j3ba586ceq124016bb7eb9d7b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 11E7924495
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 18:38:09 +0200 (CEST)
Received: by qyk15 with SMTP id 15so4642763qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 04 Aug 2009 09:38:08 -0700 (PDT)
In-Reply-To: <eedb5540908040818j3ba586ceq124016bb7eb9d7b5@mail.gmail.com>
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

Hi all!

Mates, I am following the example PCM.C that I found at alsa web site. 
its a sine wave generator.
I am looking for a control that alsa provides to control the amplitude 
of the wave.

As I could found so for, there is just frequency control... I didn't 
find any amplitude control.

* I don't want to control the volume using alsamixer or even my sound... 
I want to generate a wave with predefined amplitude.

Does anyone could give me a little help??

Thanks a lot!
