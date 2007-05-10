From: Steve Merrony <merrony@googlemail.com>
Subject: Capturing MIDI
Date: Thu, 10 May 2007 10:37:37 +0100
Message-ID: <4642E7E1.8070800@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id C5DD12435B
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 11:36:52 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so389075ugf
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 02:36:52 -0700 (PDT)
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

I hope this isn't too off-topic.

I run an open source project (GENPO) which can be thought of as a kind 
of MIDI switchboard and filter.  It uses ALSA throughout.  I'd like to 
add a new feature to the software - a facility to simply record to a 
standard MIDI file anything that the program produces.  I've searched 
though the API and I can't find anything documented which will help 
much, so here's my question...

Is there a recommended library for C++ ALSA programs to use for handling 
(writing) standard MIDI files?

Regards,
               Steve
