From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: AudioScience driver - need help
Date: Fri, 02 May 2003 09:35:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030502093558.pochini@shiny.it>
References: <20030501192510.17280.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030501192510.17280.h002.c012.wm@mail.icqmail.com.criticalpath.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eliot Blennerhassett <bigblen@icqmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 02-May-2003 Eliot Blennerhassett wrote:
> Hello,
>
> a few of you with long memories may recall that I was
> on this list about a year ago asking about getting
> support for our soundcards.
>
> The wheels have slowly turned, and now the company
> http://www.audioscience.com
> rather than me personally)  want to have an ALSA driver
> for our cards.

Well, donate a soundcard to one of us :))

> I have got the job of making an ALSA driver, or at
> least causing it to be made.
> How do I go about getting help from "The ALSA
> development team" (TADT) to write this driver?

Just write a message on this list. If you are looking
for 24/7 prompt support, I don't thing there is any.

> The proposed Licence is based on the Zlib one.
> http://www.gzip.org/zlib/zlib_license.html
>
> with the addition of
> X. This software may only be used in conjunction with
> audio peripherals designed by AudioScience, Inc.
>
> Is this an acceptable restriction? Or do you think that
> this make it non-GPL-compatible?

No, it's not GPL compatible. GPL does not put any
restriction to the use of the code. It put conditions
on the licence of the software which contains GPL-led
parts (ie. it must be GPL too). Obviously you cannot
use AudioScience driver with a Soundblaster, but you
can't prevent someone to modify the AS driver to work
with a SB, if the code is under GPL.


Bye.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
