From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Driver development: peak metering
Date: Tue, 13 May 2003 01:17:54 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030513011754.28032.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Our cards do peak metering of all streams, inputs and
outputs.=20=20

Is there such a thing as a peak meter control (read
only) in the ALSA driver model?  I can't find anything.

According to "Writing an ALSA Driver" by Takashi Iwai
"The third, FUNCTION, is one of the following strings
according to the function of the control: =93Switch=94,
=93Volume=94 and =93Route=94."

thanks

Eliot Blennerhassett
AudioScience Inc.
=0D


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
