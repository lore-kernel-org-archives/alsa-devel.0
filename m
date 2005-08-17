From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compulab sound device
Date: Wed, 17 Aug 2005 15:40:06 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508171538200.19860-100000@studcom.urz.uni-halle.de>
References: <20050816125813.75232.qmail@web54609.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050816125813.75232.qmail@web54609.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chow Raymond <usher_raymond82@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chow Raymond wrote:
> I can't compile a newer kernel version. This is
> because Compulab Armcore only supports till kernel
> 2.6.7 and in that contains ALSA 1.0.4.

You could backport the ARM audio changes between 2.6.7 and 2.6.12, or
you could port Compulab's changes (if any) to 2.6.12.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
