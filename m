From: Paul Fertser <fercerpav@gmail.com>
Subject: Re: Callbacks from opening or closing alsa streams
Date: Fri, 17 Jul 2009 10:46:46 +0400
Message-ID: <20090717064646.GH32116@home.pavel.comp>
References: <aceb60a00907161400q1f36f04bn7ca860186814e054@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id BAB421037E3
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 08:47:57 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so178585fga.21
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2009 23:47:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <aceb60a00907161400q1f36f04bn7ca860186814e054@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Baek Chang <baeksan@ccrma.stanford.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Jul 16, 2009 at 02:00:41PM -0700, Baek Chang wrote:
> I was wondering if it was possible to get callbacks from opening and closing
> of alsa streams with the alsa sink name that was opened.

Probably you're interested in something like this:
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-June/018996.html
(read the whole thread, it has an example code)

HTH
-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
