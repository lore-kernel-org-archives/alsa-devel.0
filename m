From: "Steven Zakulec" <spzakulec@gmail.com>
Subject: Realtek 268
Date: Tue, 5 Jun 2007 17:54:34 -0400
Message-ID: <bad0f8d0706051454t61b47275q5061ff12abebfaf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id F340C24179
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2007 23:54:35 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so454918ana
	for <alsa-devel@alsa-project.org>; Tue, 05 Jun 2007 14:54:34 -0700 (PDT)
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

Hello ALSA developers, I have one of the Intel HDA cards that is not
supported currently: Realtek 268.

It was previously mentioned in May
(http://mailman.alsa-project.org/pipermail/alsa-devel/2007-May/000828.html).

The post seemed to imply it was not a terribly difficult task to add
support for the card, but was very vague on details.  If it is in fact
just a matter of copying an existing preset and changing the values, I
would probably try to do it myself.  If it is any more difficult than
that, I'd like to formally ask the developers if they could add any
support for the card.  The lspci and /proc/asound/codec info is
identical to that in the posting I mentioned.  If you need anymore
information, I would be happy to provide it.

Thank you!
