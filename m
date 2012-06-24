From: Guy Rutenberg <guyrutenberg@gmail.com>
Subject: Exclusive access to capture device
Date: Sun, 24 Jun 2012 23:17:37 +0300
Message-ID: <CADfV-LGfSwGU6fdBeWqtW4-4rpux0NeneV=7uEe4dFbyBs9NGA@mail.gmail.com>
References: <CADfV-LHztneYAZJusarOSTv3qXuECWqrQajqLEKCsJC82yvULA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E9E7243AA
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2012 22:17:58 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so5222274obb.38
	for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2012 13:17:57 -0700 (PDT)
In-Reply-To: <CADfV-LHztneYAZJusarOSTv3qXuECWqrQajqLEKCsJC82yvULA@mail.gmail.com>
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

Hi,

Is there a way to open a capture device exclusively? E.g. I want to capture
audio and be sure no other application can capture from that device at the
same time.

I've went through the API and searched the mailing list and haven't found a
way to do so.

Thanks a lot,

Guy

----
http://www.guyrutenberg.com/
