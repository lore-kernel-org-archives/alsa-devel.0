From: rmgls@free.fr
Subject: Re: mbox II
Date: Mon, 26 Nov 2007 16:27:40 +0100
Message-ID: <20071126152742.9A9FE3227E9@smtp7-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 250712483C
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 16:27:43 +0100 (CET)
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id B6607322809
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 16:27:42 +0100 (CET)
Received: from free.fr (evr27-1-88-172-40-194.fbx.proxad.net [88.172.40.194])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 9A9FE3227E9
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 16:27:42 +0100 (CET)
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


Hi Clemens and list,

...

> try plughw
...

i tried:
aplay plughw:0 (plughw:0,0) (plughw:0,1) (plughw:0,2) coq.wav

this time no coredump, aplay try to play, but no sound on the monitoring
of the mbox II, a complete silence.

- perhaps the mixer is muted!

i cannot adjust the mixer:
amiser
no elements found.


the technical support contacted tell me: they have no tech doc for the box.
i will try on the duc forum on digidisign.com.
i am unsure to have something there!

otherwise, is a wrapper to the win driver suitable, or even possible?

thanks.

best regards

Raoul
rmgls@free.fr
