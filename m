From: "Andrew Boettcher" <a.boettcher@gmail.com>
Subject: Merging hg sources into kernel tree
Date: Tue, 19 Feb 2008 21:18:05 -0500
Message-ID: <6a316a6e0802191818j4a02dcc8s5a2d4a687c605749@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 4116E24388
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 03:18:06 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so2438922fka.0
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 18:18:05 -0800 (PST)
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

Is there a script to merge the hg sources into a kernel tree?  If not do I
need to worry about any changes other than the include/ directory?  I have
another module (cx88-alsa) that is in v4l but needs the newer alsa tree or I
get "cx88_alsa: disagrees about version of symbol xxx", so I have to merge
the sources for now.

Andrew Boettcher
