From: Roy Huang <royhuang9@gmail.com>
Subject: How to compile alsa-lib without libdl?
Date: Thu, 17 Nov 2005 17:00:43 +0800
Message-ID: <afe668f90511170100ve7eed36pac3e9ce7141f05d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_52808_12332638.1132218043253"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_52808_12332638.1132218043253
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am trying to compile alsa-lib to run on uClinux. The library is uClibc an=
d
is complied as static too. So uClibc doesn't provide dl functions like
dlopen, dlclose. But alsa-lib need this function, does anyone has the same
experience about this? thanks ahead.

- Roy

------=_Part_52808_12332638.1132218043253
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, <br>
<br>
I am trying to compile alsa-lib to run on uClinux. The library is
uClibc and is complied as static too. So uClibc doesn't provide dl
functions like dlopen, dlclose. But alsa-lib need this function, does
anyone has the same experience about this? thanks ahead.<br>
<br>
&nbsp;- Roy<br>

------=_Part_52808_12332638.1132218043253--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
